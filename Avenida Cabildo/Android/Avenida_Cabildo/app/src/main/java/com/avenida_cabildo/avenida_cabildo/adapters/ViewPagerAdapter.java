package com.avenida_cabildo.avenida_cabildo.adapters;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentStatePagerAdapter;

import java.util.ArrayList;

public class ViewPagerAdapter extends FragmentStatePagerAdapter {

	ArrayList<Fragment> fragmentos = new ArrayList<>();
	ArrayList<String> nombres = new ArrayList<>();
	
	public ViewPagerAdapter(FragmentManager fm) {
		super(fm);
	}

	public void agregarFragmento(Fragment fragment, String nombre){
		fragmentos.add(fragment);
		nombres.add(nombre);
	}
	
	@Override
	public int getCount() {
		return fragmentos.size();
	}
	
	@Override
	public CharSequence getPageTitle(int position) {
		return nombres.get(position);
	}

	@Override
	public Fragment getItem(int position) {
		return fragmentos.get(position);
	}

}
